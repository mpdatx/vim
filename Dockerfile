FROM debian:jessie
RUN apt-get update && apt-get install -y mercurial git build-essential cmake python-dev libncurses5-dev
RUN hg clone https://code.google.com/p/vim/
# ADD swap.sh /swap.sh
# RUN /swap.sh
RUN cd vim && \
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr \
	&& make VIMRUNTIMEDIR=/usr/share/vim/vim74 \
	&& make install
RUN git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ADD vimrc /.vimrc
RUN vim +PluginInstall +qall 
RUN cd ~/.vim/bundle/YouCompleteMe/ && ./install.sh
# ENTRYPOINT ["vim"]
