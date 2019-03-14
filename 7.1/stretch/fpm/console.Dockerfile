FROM my127/php:7.1-fpm-stretch-console

# tool: redis-cli
# ---------------
# we copy instead of using redis-cli or redis-tools due to inconsistent versions
COPY --from=redis:5.0 /usr/local/bin/redis-cli /usr/local/bin/redis-cli
