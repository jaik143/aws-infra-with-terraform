#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>Webserver</title>
  <style>
    body {
      background-color: #f0f8ff;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      height: 100vh;
      font-family: Arial, sans-serif;
      color: #333;
      text-align: center;
    }
    h1 {
      color: #4CAF50;
      font-size: 3em;
    }
    p {
      font-size: 1.5em;
    }
  </style>
</head>
<body>
  <h1>My Apache Backend Server1</h1>
  <p>By Kadali Jayanth kumar</p>

</body>
</html>
EOF
