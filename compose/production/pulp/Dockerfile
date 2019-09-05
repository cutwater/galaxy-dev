FROM centos:7

ENV PYTHONUNBUFFERED=1 \
    LANG=en_US.UTF-8 \
    PULP_CODE=/code \
    PULP_VENV=/venv \
    DJANGO_SETTINGS_MODULE=pulpcore.app.settings

RUN yum -y install epel-release \
    && yum -y install \
        git \
        python36 \
        python36-devel \
    && yum -y clean all

RUN mkdir -p /var/run/pulp \
    /var/lib/pulp/tmp

COPY compose/production/pulp/requirements.txt /tmp/pulp/

COPY pulp-ansible /code/pulp-ansible

RUN python3.6 -m venv "${PULP_VENV}" \
    && source "${PULP_VENV}/bin/activate" \
    && pip --no-cache-dir install -U \
        'pip<19.0' \
        wheel \
    && cd /tmp/pulp \
    && pip install -r requirements.txt \
    && pip install -e /code/pulp-ansible

ENV PATH="/venv/bin:$PATH"

COPY compose/production/pulp/entrypoint.sh /entrypoint
COPY compose/production/pulp/settings.py etc/pulp/settings.py

VOLUME /data/

WORKDIR /code/

RUN useradd --no-create-home --user-group django
RUN chmod +x /entrypoint
RUN chown django /entrypoint

RUN chown django:root /var/run/pulp \
    /var/lib/pulp/tmp
RUN chmod g+w /var/run/pulp \
    /var/lib/pulp/tmp

USER django

ENTRYPOINT [ "/entrypoint" ]
