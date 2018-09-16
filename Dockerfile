FROM ruby:2.3.0
EXPOSE 3000
RUN apt-get update && apt-get -y install nodejs zsh postgresql-client
RUN useradd -m docker
USER docker
WORKDIR /home/docker
RUN mkdir box
ENV BUNDLE_PATH /home/docker/box
ENV HISTFILE /home/docker/.bash_history
RUN echo "export PATH=/home/docker/bin:$PATH" >> ~/.bashrc
