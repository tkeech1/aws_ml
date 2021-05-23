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

RUN apt update && apt install zip -y && rm -rf /var/lib/apt/lists/*
RUN curl -L https://releases.hashicorp.com/terraform/0.12.12/terraform_0.12.12_linux_amd64.zip -o /tmp/tf.zip; unzip /tmp/tf.zip -d /usr/local/bin/; rm /tmp/tf.zip

# node is required for installing jupyterlab extensions
#RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
#RUN apt-get update && apt-get install -y nodejs openjdk-8-jdk && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y docker-compose && rm -rf /var/lib/apt/lists/*
RUN pip uninstall -y enum34
RUN pip install --upgrade pip

# change the username
USER $USERNAME
ENV PATH="${PATH}:/home/${USERNAME}/.local/bin"

#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
#RUN export JAVA_HOME

# install python libraries
RUN pip install dask dask_ml dask[dataframe] featuretools h2o \
    keras seaborn mnist scikit-learn awscli pylint autopep8 \
    boto3 pandas quandl numpy pandas_datareader sagemaker \
    voila textblob plotly_express jupyterlab fbprophet line_profiler memory_profiler sagemaker[local] \
    tableauhyperapi pantab \
    --upgrade --user

RUN pip install modin modin[dask] line_profiler memory_profiler\
    --upgrade --user

# install an extension
#RUN /home/$USERNAME/.local/bin/jupyter-labextension install @jupyter-widgets/jupyterlab-manager@1.1 --no-build
#RUN /home/$USERNAME/.local/bin/jupyter-labextension install jupyterlab-plotly@1.5.0 --no-build
#RUN /home/$USERNAME/.local/bin/jupyter-labextension install plotlywidget@1.5.0 --no-build
#RUN /home/$USERNAME/.local/bin/jupyter-lab build

RUN mkdir ~/.jupyter