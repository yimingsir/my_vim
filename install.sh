#!/bin/bash
vundle_git=https://github.com/VundleVim/Vundle.vim.git
bundle_path=~/.vim/bundle

function pre_install()
{
    local ret

    which git 1>/dev/null 2>&1
    ret=$?
    if [$ret -ne 0]; then
        echo "Error, git command not found"
        exit 1
    fi

    which vim 1>/dev/null 2>&1
    ret=$?
    if [$ret -ne 0]; then
        echo "Error, vim command not found"
        exit 1
    fi
}

function main()
{
    local ret

    echo "Prepare installl..."
    pre_install

    echo "Create directory..."
    mkdir -p $bundle_path
    ret=$?
    if [$ret -ne 0 -a ! -d $bundle_path]; then
        echo "Error, create directory fail"
        exit 1
    fi

    echo "Clone vundle resposity..."
    cd $bundle_path
    ret=$?
    if [$ret -ne 0]; then
        echo "Error, enter directory fail"
        exit 1
    fi
    git clone $vundle_git
    ret=$?
    if [$ret -ne 0]; then
        echo "Error, clone vundle resposity fail"
        exit 1
    fi

    echo "Start install vim plugins..."
    sleep 1
    vim +PluginInstall +qall
    ret=$?
    if [$ret -ne 0]; then
        echo "Error, vim install plugin fail"
        exit 1
    fi

    echo "Okay~"
}

# main
main
