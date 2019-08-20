FROM centos:7

ENV PYTHONUNBUFFERED=1 \
    LANG=en_US.UTF-8 \
    GALAXY_CODE=/code \
    GALAXY_VENV=/venv \
    DJANGO_SETTINGS_MODULE=galaxy_api.settings

RUN yum -y install epel-release \
    && yum -y install \
        git \
        python36 \
        python36-devel \
        pcre \
        pcre-devel \
        gcc \
    && yum -y clean all

COPY galaxy-api/Pipfile \
    galaxy-api/Pipfile.lock \
    /tmp/galaxy-api/

COPY galaxy-api /code/galaxy-api

RUN python3.6 -m venv "${GALAXY_VENV}" \
    && source "${GALAXY_VENV}/bin/activate" \
    && pip --no-cache-dir install -U \
        'pip<19.0' \
        wheel \
        pipenv \
    && cd /tmp/galaxy-api \
    && PIPENV_VERBOSITY=-1 pipenv install --ignore-pipfile \
    && pip install -e /code/galaxy-api \
    && pip install uwsgi


WORKDIR /code/

ENV PATH="/venv/bin:$PATH"

RUN groupadd django \
    && adduser -g django django

COPY compose/production/galaxy-api/entrypoint /entrypoint
RUN sed -i 's/\r//' /entrypoint
RUN chmod +x /entrypoint
RUN chown django /entrypoint
COPY compose/production/galaxy-api/start /start
RUN sed -i 's/\r//' /start
RUN chmod +x /start
RUN chown django /start


USER django
ENTRYPOINT [ "/entrypoint" ]
CMD [ "/start" ]
