FROM sd2e/reactors:python2

# Install a much specialized content and configuration here


# Re-add ONBUILD support since this is derived from
# an reactors image that has it
ONBUILD ADD requirements.txt /tmp/requirements.txt
ONBUILD RUN pip install --upgrade -r /tmp/requirements.txt
ONBUILD ADD reactor.py /
ONBUILD ADD config.yml /
ONBUILD ADD message.json* /message.jsonschema

# Close out making absolutely sure that work directory is set
WORKDIR ${SCRATCH}
