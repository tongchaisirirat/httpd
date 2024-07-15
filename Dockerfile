# ใช้ base image ของ Apache HTTP Server
FROM httpd:2.4

# ตั้งค่า health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:80 || exit 1

# กำหนด port ที่จะ expose
EXPOSE 80

# แสดงข้อความ success หลังจากการ build เสร็จสิ้น
RUN echo "success"
