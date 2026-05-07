# 使用官方鏡像作為 base
FROM ghcr.io/juanfont/headscale:v0.28.0 AS base

# 使用 Alpine 作為運行環境（為咗有 Terminal 同 Shell）
FROM alpine:3.20

# 1. 【關鍵修正】官方 binary 真正位置係 /ko-app/headscale
COPY --from=base /ko-app/headscale /usr/bin/headscale

# 2. 安裝必要工具並建立目錄
# 我哋唔用 COPY 複製目錄，直接喺度建立，最穩陣
RUN apk add --no-cache bash curl ca-certificates su-exec && \
    mkdir -p /etc/headscale /var/lib/headscale /var/run/headscale && \
    chmod -R 755 /etc/headscale /var/lib/headscale /var/run/headscale && \
    chmod +x /usr/bin/headscale

EXPOSE 8080 9090 50443

# 執行指令
CMD ["headscale", "serve"]
