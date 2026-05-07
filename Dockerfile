FROM headscale/headscale:v0.28.0

# 复制配置文件（路径必须正确）
COPY config.yaml /etc/headscale/config.yaml

# 正确启动方式：只传 "serve" 参数
CMD ["serve"]
