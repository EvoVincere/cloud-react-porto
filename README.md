# ☁️ Secure AWS Network Architecture & React Deployment (Simulated via LocalStack)

## 📌 Deskripsi Proyek
Proyek ini adalah simulasi pembangunan arsitektur Cloud AWS yang aman menggunakan pendekatan **Infrastructure as Code (IaC)**. Saya merancang arsitektur jaringan dari nol untuk memisahkan *environment* aplikasi (*Frontend* dan *Backend*) menggunakan prinsip *Security by Design*, serta men-deploy website React.js secara lokal tanpa biaya menggunakan LocalStack.

## 🛠️ Tech Stack yang Digunakan
* **Infrastructure as Code:** Terraform
* **Cloud Emulator:** LocalStack & Docker
* **CLI Tools:** AWS CLI
* **Frontend:** React.js

## 🏗️ Desain Arsitektur (Security by Design)
*[Masukkan Gambar Diagram Arsitektur Draw.io di sini]*

Dalam proyek ini, saya mengimplementasikan strategi *Subnetting* untuk keamanan:
1. **Frontend Hosting (S3 Bucket):** Aplikasi React.js di- *deploy* sebagai *Static Website* di S3 untuk efisiensi biaya dan skalabilitas tinggi.
2. **Public Subnet (Zona Akses Internet):** Dilengkapi dengan *Internet Gateway* (IGW). Disiapkan untuk penempatan Load Balancer atau Web Server di masa depan.
3. **Private Subnet (Zona Terisolasi):** Tidak memiliki jalur langsung ke internet. Didesain khusus untuk mengamankan Database dari potensi serangan siber langsung dari luar.

## 🚀 Bukti Eksekusi (Proof of Work)

### 1. Provisioning Infrastruktur dengan Terraform
<img width="940" height="267" alt="image" src="https://github.com/user-attachments/assets/09bd8663-5727-4f74-b982-8eb37bf317f5" />

Proses pembuatan VPC, Subnet, Route Table, dan S3 dilakukan sepenuhnya otomatis menggunakan Terraform.

### 2. Validasi Jaringan via AWS CLI
<img width="940" height="165" alt="image" src="https://github.com/user-attachments/assets/b16bb8dc-cbf4-437a-9703-392c1680fdad" />

Verifikasi bahwa konfigurasi CIDR block (`10.0.1.0/24` dan `10.0.2.0/24`) telah terpasang dengan benar.

### 3. Hasil Deployment React.js
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/4eaef4f8-85fd-47c7-98a3-0670cbfc0293" />

Aplikasi *frontend* berhasil diakses melalui S3 *bucket web endpoint*.

## 💡 Apa yang Saya Pelajari dari Proyek Ini?
* Memahami cara kerja CIDR Notation dalam membagi kapasitas IP jaringan.
* Memahami pentingnya pemisahan *Route Table* untuk *Public* dan *Private Subnet*.
* Menyadari efisiensi penggunaan Terraform dibandingkan melakukan konfigurasi manual (*ClickOps*) di Cloud Console.
