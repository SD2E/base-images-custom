FROM sd2e/reactors:python3
# FROM sd2e/reactors:python3-edge

# for xplan_to_sbol
RUN apt-get update && \
    apt-get -y install libxslt1-dev && \
    apt-get clean

ARG SBHADAPTER_BRANCH=master
ARG SBOL_BRANCH=master
ARG XPLAN_TO_SBOL_BRANCH=master

RUN pip3 install https://github.com/tcmitchell/pySBOL/blob/ubuntu/Ubuntu_16.04_64_3/dist/pySBOL-2.3.0.post11-cp36-none-any.whl?raw=true

RUN pip3 install --upgrade git+https://github.com/nroehner/pySBOLx.git@${SBOL_BRANCH}
RUN pip3 install --upgrade git+https://github.com/SD2E/xplan_to_sbol.git@${XPLAN_TO_SBOL_BRANCH}
RUN pip3 install --upgrade git+https://github.com/SD2E/synbiohub_adapter.git@${SBHADAPTER_BRANCH}


# Re-add ONBUILD support since this is derived from
# an reactors image that has it
ONBUILD ADD requirements.txt /tmp/requirements.txt
ONBUILD RUN pip install --upgrade -r /tmp/requirements.txt
ONBUILD ADD reactor.py /
ONBUILD ADD config.yml /
ONBUILD ADD message.json* /message.jsonschema
# This ensures that reactor.py, config.yml, and message.jsonschema
# will be automatically added to derived containers on docker build

# Close out making absolutely sure that work directory is set
WORKDIR ${SCRATCH}
