FROM ghcr.io/juanfont/headscale:v0.28.0 AS base

FROM alpine:3.20

# 複製 Headscale 主程式（正確路徑）
COPY --from=base /ko-app/headscale /usr/bin/headscale

# 複製預設配置目錄（如果存在，失敗就跳過）
COPY --from=base /etc/headscale /etc/headscale || true

# 安裝 shell 工具 + 建立必要目錄（解決 Terminal）
RUN apk add --no-cache bash curl ca-certificates su-exec && \
    mkdir -p /etc/headscale /var/lib/headscale /var/run/headscale && \
    chmod -R 755 /etc/headscale /var/lib/headscale /var/run/headscale && \
    chmod +x /usr/bin/headscale

EXPOSE 8080 9090 50443
CMD ["headscale", "serve"]
