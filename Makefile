NAME	=	inception

COMPOSE	=	cd srcs && docker-compose -p $(NAME)

all:
	$(COMPOSE) up --build

clean:
	$(COMPOSE) stop

fclean:	clean
	$(COMPOSE) down -v

prune: fclean
	docker system prune --volumes --force --all
	rm -rf volumes/mariadb_volume/*

re: prune all

run: all
	docker run -d -p 80:80 nginx_inception

PHONY: all clean fclean prune re