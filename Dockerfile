# ==========================================
# 終極下載版 - 唔再用 COPY 避開路徑報錯
# ==========================================
FROM alpine:3.20

# 1. 裝工具
RUN apk add --no-cache bash curl ca-certificates su-exec

# 2. 直接由 GitHub 官方攞 Binary (AMD64 版本)
RUN curl -L https://github.com/juanfont/headscale/releases/download/v0.28.0/headscale_0.28.0_linux_amd64 -o /usr/bin/headscale && \
    chmod +x /usr/bin/headscale

# 3. 預備目錄
RUN mkdir -p /etc/headscale /var/lib/headscale /var/run/headscale && \
    chmod -R 755 /etc/headscale /var/lib/headscale /var/run/headscale

EXPOSE 8080 9090 50443

CMD ["headscale", "serve"]
