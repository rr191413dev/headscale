FROM headscale/headscale:v0.28.0 AS base

# 使用 Alpine 作為最終鏡像，加入必要工具
FROM alpine:3.20

# 複製 Headscale 二進位和預設檔案
COPY --from=base /usr/bin/headscale /usr/bin/headscale
COPY --from=base /etc/headscale /etc/headscale

# 安裝基礎工具（解決 Terminal + cat/ls 等問題）
RUN apk add --no-cache bash curl ca-certificates su-exec

# 建立必要目錄權限
RUN mkdir -p /etc/headscale /var/lib/headscale && \
    chmod -R 755 /etc/headscale

EXPOSE 8080 9090 50443
CMD ["headscale", "serve"]
