Local role with tasks related to proaluno room.

# Features & To-Do

- [X] Update sources list;
- [X] Install GUI
  - [X] Set default GUI and install {default}-task-desktop;
  - [X] Import visual configs (copying settings file to /etc/skel);
- [X] Create proaluno folder and send login, logout and keyboard files;
- [X] Lightdm configs
  - Lightdm run scripts on login and logout to delete user files, set desktop background, etc.
- [X] Restrict shutdown
  - Its a script that removes the poweroff and hibernate buttons. Only the restart button still avaible.
- [X] Install Debian packages
  - A selected list of packages needs to be installed in every computer.
- [X] Cron to shutdown all the pcs at 11pm (default);
- [ ] Cron to start all the pcs at a pre-defined time;
- [X] Disable screenlock;
  - At least with XFCE...
- [ ] Send status to the Monitoring system
  - Every pc needs to send its status periodically. As status we defined these infos: ip, hostname, username, login_at and logout_at (if is the case).