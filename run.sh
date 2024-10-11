#!/bin/bash

# 定义颜色变量
GREEN='\033[0;32m'
NC='\033[0m' # 没有颜色

# 检查 .env 文件是否存在
if [ ! -f .env ]; then
  echo "未找到 .env 文件，请先创建 .env 文件。"
  exit 1
fi

# 启动 Docker 容器的函数
start_containers() {
  echo -e "${GREEN}启动 MongoDB 容器...${NC}"
  docker compose -f docker-compose.yaml up -d
}

# 停止 Docker 容器的函数
stop_containers() {
  echo -e "${GREEN}停止 MongoDB 容器...${NC}"
  docker compose down
}

# 查看日志的函数
view_logs() {
  echo -e "${GREEN}显示 MongoDB 容器日志...${NC}"
  docker compose logs -f
}

# 检查容器状态的函数
check_status() {
  echo -e "${GREEN}查看 MongoDB 容器状态...${NC}"
  docker compose ps
}

# 重启容器的函数
restart_containers() {
  stop_containers
  start_containers
}

# 重建容器的函数
rebuild_containers() {
  stop_containers
  echo -e "${GREEN}重建 MongoDB 容器...${NC}"
  docker compose up -d --force-recreate
}


# 打印菜单的函数
print_help() {
  echo "使用方法: ./run.sh [选项]"
  echo "选项:"
  echo "  start       启动 MongoDB 容器"
  echo "  stop        停止 MongoDB 容器"
  echo "  restart     重启 MongoDB 容器"
  echo "  rebuild     重建 MongoDB 容器"
  echo "  status      查看 MongoDB 容器状态"
  echo "  logs        查看 MongoDB 容器日志"
  echo "  help        显示帮助信息"
}

# 检查传入的参数
case "$1" in
  start)
    start_containers
    ;;
  stop)
    stop_containers
    ;;
  restart)
    restart_containers
    ;;
  rebuild)
    rebuild_containers
    ;;
  status)
    check_status
    ;;
  logs)
    view_logs
    ;;
  help|*)
    print_help
    ;;
esac
