from atelier.invlib import setup_from_tasks
ns = setup_from_tasks(
    globals(),
    blogref_url="http://luc.lino-framework.org",
    revision_control_system='git',
    )
