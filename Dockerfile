# 使用官方 distroless 基础镜像
FROM headscale/headscale:v0.28.0

# 复制你的配置文件（必须放在 /etc/headscale/config.yaml）
COPY config.yaml /etc/headscale/config.yaml

# 可选：如果需要把 private key 等也预置，可以在这里 COPY

# 启动命令（明确指定）
CMD ["headscale", "serve"]
