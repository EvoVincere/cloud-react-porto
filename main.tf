# Config Provider (EC2 dan S3 ke localstack)
provider "aws" {
  region                      = "ap-southeast-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    ec2 = "http://localhost:4566"
    s3  = "http://localhost:4566"
  }
}

# Create VPC (Rumah Utama)
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "cloud-react-vpc"
  }
}

# Create Public Subnet (Ruang Publik)
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "cloud-react-public-subnet"
  }
}

# Create Private Subnet (Ruang Privat)
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "cloud-react-private-subnet"
  }
}

# Create Internet Gateway (Gerbang Internet)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "cloud-react-igw"
  }
}

# Create Route Table & Menyambungkan ke Public Subnet
resource "aws_route_table" "public_route"{
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "cloud-react-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route.id
}

# Create S3 Bucket (Hosting React App)
resource "aws_s3_bucket" "react_app_bucket" {
  bucket = "cloud-react-app-bucket"
}

# Konfigurasi S3 agar berfungsi sebagai website hosting
resource "aws_s3_bucket_website_configuration" "react_site" {
  bucket = aws_s3_bucket.react_app_bucket.id

  index_document {
    suffix = "index.html"
  }
}