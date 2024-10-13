# Create Transit Gateway
resource "aws_ec2_transit_gateway" "this" {
  description = "Transit Gateway for EKS"
  
  amazon_side_asn = var.amazon_side_asn
  tags = {
    Name = "eks-transit-gateway"
  }
}

# Create Transit Gateway Route Table
resource "aws_ec2_transit_gateway_route_table" "this" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id

  tags = {
    Name = "eks-transit-gateway-rt"
  }
}

# Associate Transit Gateway with VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attachment" {
  count               = length(var.vpc_ids)
  subnet_ids          = var.private_subnet_ids[count.index]
  transit_gateway_id  = aws_ec2_transit_gateway.this.id
  vpc_id              = var.vpc_ids[count.index]
  
  tags = {
    Name = "tg-vpc-attachment-${count.index}"
  }
}

# Associate Transit Gateway Route Table with Attachment
resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count                = length(var.vpc_ids)
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_attachment[count.index].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}