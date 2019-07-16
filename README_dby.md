brickman
========

Kompilieren eines "eigenen" Brick Managers.

#### Vorwort ####
Die nachfolgenden Schritte beschreiben Workarounds, da die "offiziellen" Anleitungsschritte nicht funktionieren. Besser wäre es natürlich die Ursachen zu beheben.

Als <b>Docker Host</b> wurde ein <b>Debian 9</b> System verwendet, d.h. alle genannaten Pakete beziehen sich auf dieses System!

#### Repository holen ####

* Klones des brickman repos.

        git clone git://github.com/ev3dev/brickman
        cd brickman
        git submodule update --init --recursive


#### Docker Host einrichten ####

* Docker und qemu installieren (benötigt Linux/macOS 10.10.3+/Window 10 Pro). Konkret wurde für diese Anleitung Debian 9 verwendet.

        sudo apt install docker-ce qemu-efi qemu-system-arm qemu-user-static



#### Builds für EV3 erstellen ####


* In das zuvor geklonte "brickman" Verzeichnis wechseln und das folgende Docker Script mit Parameteter `armel` ausführen.
<br><b>Hinweis:</b> Die offizielle Dokumentation verwendet hier noch einen weiteren Parameter `$BUILD_AREA`, dieser wurde aber offenbar nicht korrekt implementiert und wird daher hier nicht berücksichtigt.

        ./docker/setup.sh armel

* Die Einrichtung des Containers wird vermutlich mit einer CMake Fehlmeldung enden. Das ist erstmal kein Problem, da wir diese durch die folgenden Schritte umgehen.

*   Der Docker Container namens `brickman-armel` sollte jetzt laufen. Nun die Container ID ermitteln mit:

        docker ps

*   Den Container betreten und eine Bash Sitzung starten.

        docker exec -i --tty <ContainerID> /bin/bash
        z.B. docker exec -i --tty 58f088e62e45 /bin/bash

*   Packet `OpenSSH-client` und `git` in dem Container installieren

        sudo apt install openssh-client git


*   In das Home Verzeichnis wechseln, einen Ordner `git` anlegen und den aktuellen Quellcode herunterladen

        cd ~
        mkdir git
        cd git
        git clone git://github.com/ev3dev/brickman
        cd brickman
        git submodule update --init --recursive


*    In dem Verzeichnis cmake aufrufen, es sollten alle Modul Checks erfolgreich durchlaufen.

          cmake -DCMAKE_BUILD_TYPE=string:Debug

*     Der Quellcode (für Anpassungen, Änderungen) befindet sich im Unterverzeichnis `src`

*     Mit den Aufruf von `make install` im `brickman` Verzeichnis wird eine neue Version kompiliert, die fertig kompilierte Datei befindet sich dann direkt in diesem Verzeichnis.

*    Kopieren des neuen Builds auf den Brick. (Container -> Brick)

          scp brickman <USER>@<RobotIP>:/home/robot
          z.B. scp brickman robot@192.168.0.103:/home/robot

*   Kopieren der Datei ins Zielverzeichnis und Neustarten des Brickman Service.

           sudo mv /usr/sbin/brickman /usr/sbin/brickman_old
           sudo cp -f ~/brickman /usr/sbin/brickman
           sudo systemctl restart brickman.service


* Das wars! Jetzt läuft auf dem Brick der eigene Brickman.
