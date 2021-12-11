FROM ruby:3-alpine

RUN apk --update add --no-cache zsh zsh-vcs git curl wget vim build-base libxml2-dev libxslt-dev postgresql-dev tzdata nodejs yarn

ENV HOME=/home/ruby
ENV APP=${HOME}/app
ENV ZSH_CUSTOM=${HOME}/.oh-my-zsh

USER root

WORKDIR ${HOME}

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
  git clone https://github.com/denysdovhan/spaceship-prompt.git "${ZSH_CUSTOM}/themes/spaceship-prompt" && \
  ln -s "${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM}/themes/spaceship.zsh-theme" && \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)" && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "${HOME}/zsh-syntax-highlighting" && \
  git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM}/plugins/zsh-completions" && \
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"

COPY ./terminal/.zshrc ${HOME}/.zshrc

WORKDIR ${APP}

RUN gem install pg reek rubocop solargraph rails

WORKDIR ${APP}
