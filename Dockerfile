FROM headscale/headscale:v0.28.0

# 复制配置
COPY config.yaml /etc/headscale/config.yaml

# 确保目录和权限
RUN mkdir -p /var/lib/headscale && \
    chmod 755 /var/lib/headscale

CMD ["headscale", "serve"]
