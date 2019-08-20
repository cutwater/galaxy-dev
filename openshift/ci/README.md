

OpenShift Descriptors and playbooks to automate their creation and update.

    open_shift_descriptors.yml  contains a list of all the descriptors.

    create_open_shift.yml will initially create all the entries in openshift

    replace_open_shift.yml will update the existing entries in openshift


Usage:

    ansible-playbook create_open_shift.yml

    ansible-playbook replace_open_shift.yml
