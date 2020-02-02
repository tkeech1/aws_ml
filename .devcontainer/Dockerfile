FROM tensorflow/tensorflow:2.0.0-py3-jupyter

ARG USERNAME=tk
# On Linux, replace with your actual UID, GID if not the default 1000
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && mkdir -p /home/$USERNAME/.vscode-server /home/$USERNAME/.vscode-server-insiders \
    && chown ${USER_UID}:${USER_GID} /home/$USERNAME/.vscode-server*

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

RUN curl -L https://releases.hashicorp.com/terraform/0.12.12/terraform_0.12.12_linux_amd64.zip -o /tmp/tf.zip; unzip /tmp/tf.zip -d /usr/local/bin/; rm /tmp/tf.zip
RUN apt update && apt install zip -y && rm -rf /var/lib/apt/lists/*

# node is required for installing jupyterlab extensions
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update && apt-get install -y nodejs openjdk-8-jdk && rm -rf /var/lib/apt/lists/*

# change the username
USER $USERNAME

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# install an extension
RUN /home/$USERNAME/.local/bin/jupyter-labextension install @jupyter-widgets/jupyterlab-manager@1.1 --no-build
RUN /home/$USERNAME/.local/bin/jupyter-labextension install jupyterlab-plotly@1.5.0 --no-build
RUN /home/$USERNAME/.local/bin/jupyter-labextension install plotlywidget@1.5.0 --no-build
RUN /home/$USERNAME/.local/bin/jupyter-lab build

# install python libraries
RUN pip install dask dask_ml dask[dataframe] featuretools h2o \
    keras seaborn mnist scikit-learn awscli pylint autopep8 \
    boto3 pandas quandl numpy pandas_datareader sagemaker \
    voila textblob plotly_express jupyterlab fbprophet \
    --upgrade --user

RUN mkdir ~/.jupyter