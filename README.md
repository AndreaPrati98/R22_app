# R22_app

'R22' is the code to identify a course of [ESIEE](https://www.esiee.fr/) university (Paris). \
Here it's possible to find informations only concerning this code and what it's meant for, in order to retrieve more details about the course itself it would be etter to dig into ESIEE's website.

This application is built with [Flutter](https://flutter.dev/), an amazing framework backed by Google that allows to develop cross-platform applications.

The reasons why the idea of this application cames out is because the R22 team has a fantastic [Wio Terminal](https://wiki.seeedstudio.com/Wio-Terminal-Getting-Started/) with some extra sensors and it's possible to use it to measure some medical parameters such as: Spo2, temperature and movements (with accelerometer).

## The application
The idea behind this application is to make possible to record live the data recorded and streamed by the **WIO Terminal**. 

Therefore, the application is logically splitted in 3 sections:
- Bluetooth connection: this section is used to handle the connection with the device
- Recording: it is used to handle the recordings on the phones. Start and Stop the recording
- Share: this section is the less developed, it is meant to be the screem from which is possible to share in different ways the recordings.

# Please have a look to the _WIKI_
