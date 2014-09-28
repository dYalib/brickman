/*
 * brickman -- Brick Manager for LEGO Mindstorms EV3/ev3dev
 *
 * Copyright (C) 2014 David Lechner <david@lechnology.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * NetworkConnectionsWindow.vala:
 *
 * Displays list of network connections.
 */

using Gee;
using EV3devKit;

namespace BrickManager {
    class NetworkConnectionsWindow : BrickManagerWindow {
        internal EV3devKit.Menu menu;

        public signal void connection_selected (Object user_data);

        public NetworkConnectionsWindow () {
            title = "Network Connections";
            menu = new EV3devKit.Menu () {
                spacing = 2
            };
            content_vbox.add (menu);
        }
    }
}
