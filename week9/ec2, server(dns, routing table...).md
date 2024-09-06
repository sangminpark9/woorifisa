# 44일차

---
# Server 생성
01. VPC 생성
    FISAYEONJI-PRD-VPC : 10.250.0.0/16  (65,563)

02. Subnet 생성
   
    1) AZ : 2A
    FISAYEONJI-PRD-VPC-Docker-PUB-2A    (10.250.4.0/24) - 251      FISAYEONJI-PRD-VPC-Docker-PUB-SG-2A (80,443)
    ### ec2 name: FISAYEONJI-PRD-VPC-Docker-PUB-2A : 10.250.4.107
     
    FISAYEONJI-PRD-VPC-DJANGO-PRI-2A     (10.250.2.0/24) - 251      FISAYEONJI-PRD-VPC-DJANGO-PRI-SG-2A
    ### ec2 name: FISAYEONJI-PRD-VPC-DJANGO-PRI-2A : 10.250.2.115
     
2) AZ : 2C
     
     FISAYEONJI-PRD-VPC-DJANGO-PRI-2C     (10.250.12.0/24) - 251      FISAYEONJI-PRD-VPC-DJANGO-PRI-SG-2C
     ### ec2 name: FISAYEONJI-PRD-VPC-DJANGO-PRI-2C  : 10.250.12.254
     
03. Routing 테이블 생성

    FISAYEONJI-PRD-RT-PUB-2A     FISAYEONJI-PRD-RT-PUB
    FISAYEONJI-PRD-RT-PRI-2A     FISAYEONJI-PRD-RT-PRI
    FISAYEONJI-PRD-RT-PRI-2C

04. Internet Gateway 생성  
    (Pubic Subnet에 있는 인스턴스가 인터넷을 사용할 수 있도록 해주기 위함)
    FISAYEONJI-PRD-IGW

05. NAT GATEWAY 생성     
   (Private Subnet에 있는 인스턴스가 인터넷을 사용할 수 있도록 해주기 위함)
   (연결유형 Public / 탄력적 IP 부여하고 PUB SUBNET에 붙입니다)
    FISAYEONJI-PRD-NGW-2A   -- 우리 실습환경 
    # 우리는 만들지 않음. FISAYEONJI-PRD-NGW-2C   -- 이중화를 위해 구성하는 것을 권고함.

06. KeyPair 이름 : 본인키페어.pem

07. Linux 연결사용자계정 : ubuntu 패스워드는 없음. 
   EC2 2개 IP (DJANGO)

11. ALB Security Name(보안그룹) : FISAYEONJI-PRD-ALB-SG  (80,443)

12. Target Group(대상 그룹, EC2로 이동 후 작업)      : FISAYEONJI-PRD-ALB-TG 

13. ALB Name          : FISAYEONJI-PRD-ALB

14. Autoscaling Name  : FISAYEONJI-PRD-NGINX-Auto  

15. 시작템플릿 이름   : FISAYEONJI-PRD-NGINX-TEMP
