FROM headscale/headscale:v0.28.0-debug AS base

FROM alpine:3.20

# 複製 binary（debug 版位置係 /ko-app/headscale）
COPY --from=base /ko-app/headscale /usr/bin/headscale

# 複製配置目錄（如果有）
COPY --from=base /etc/headscale /etc/headscale || true

# 安裝完整 shell 工具 + 建立目錄
RUN apk add --no-cache bash curl ca-certificates su-exec && \
    mkdir -p /etc/headscale /var/lib/headscale /var/run/headscale && \
    chmod -R 755 /etc/headscale /var/lib/headscale /var/run/headscale && \
    chmod +x /usr/bin/headscale

EXPOSE 8080 9090 50443
CMD ["headscale", "serve"]
