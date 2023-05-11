# Start the redis server
PORT=59465
redis-server --port $PORT --protected-mode no &> redis.out &
REDIS=$!

echo "Redis started on $HOSTNAME:$PORT"

python synthetic.py \
    --parsl \
    --local \
    --redis-host $HOSTNAME \
    --redis-port $PORT \
    --input-size 1 \
    --output-size 0 \
    --interval 1 \
    --count 1 \
    --sleep-time 0 \
    --output-dir runs/funcx_1mb_inputs \
    --ps-redis \
    --ps-threshold 0.01 \

# Kill the redis server
kill $REDIS

