FROM headscale/headscale:v0.28.0 AS base

FROM alpine:3.20

# 正確複製 Headscale binary（關鍵修正）
COPY --from=base /ko-app/headscale /usr/bin/headscale

# 配置目錄（如果存在就 copy，否則跳過）
COPY --from=base /etc/headscale /etc/headscale || true

# 安裝 shell 工具 + 建立必要目錄（解決 Terminal + 持久化）
RUN apk add --no-cache bash curl ca-certificates su-exec && \
    mkdir -p /etc/headscale /var/lib/headscale /var/run/headscale && \
    chmod -R 755 /etc/headscale /var/lib/headscale /var/run/headscale && \
    chmod +x /usr/bin/headscale

EXPOSE 8080 9090 50443
CMD ["headscale", "serve"]
