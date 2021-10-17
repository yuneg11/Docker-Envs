# Configs
NAME="egyun"  # Name of
GIT_NAME="EungGu Yun"
GIT_EMAIL="yuneg11@gmail.com"
SHELL_NAME="${SHELL_NAME:-zsh}"

NAS_HOME="/mnt/gsai"
CONDA_DIR="$NAS_HOME/siml/conda3"
NAS_USER_HOME="$NAS_HOME/$NAME"

# Dotfiles and Conda
# sed -i "s/# eval/eval/g" ~/.${SHELL_NAME}rc
# echo "eval '\$(/mnt/gsai/siml/conda3/bin/conda shell.zsh hook)'" >> ~/.${SHELL_NAME}rc
/mnt/gsai/siml/conda3/bin/conda init $SHELL_NAME
echo "conda activate $NAME" >> ~/.${SHELL_NAME}rc

# Config git
git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL

# Change shell
if [ "$SHELL_NAME" != "/bin/$SHELL" ] && [ "$(whoami)" = "siml" ]; then
    echo "siml" | chsh -s /bin/$SHELL_NAME > /dev/null 2>&1
    echo "Shell changed to $SHELL_NAME"
fi

# Link frequently used files
ln -sf $NAS_USER_HOME/.bin/.vscode-server ~/.vscode-server
