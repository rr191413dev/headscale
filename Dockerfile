FROM alpine:3.20

# 1. 準備基礎環境
RUN apk add --no-cache bash curl ca-certificates su-exec

# 2. 直接由 GitHub 下載 Headscale Binary (v0.28.0)
# 咁樣就唔使理會官方 Image 入面啲路徑亂唔亂
RUN curl -L https://github.com/juanfont/headscale/releases/download/v0.28.0/headscale_0.28.0_linux_amd64 -o /usr/bin/headscale && \
    chmod +x /usr/bin/headscale

# 3. 建立必要目錄
RUN mkdir -p /etc/headscale /var/lib/headscale /var/run/headscale && \
    chmod -R 755 /etc/headscale /var/lib/headscale /var/run/headscale

# 4. 暴露端口
EXPOSE 8080 9090 50443

# 5. 啟動服務
CMD ["headscale", "serve"]
