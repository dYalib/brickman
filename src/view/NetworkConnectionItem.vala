/*
 * brickdm -- Brick Display Manager for LEGO Mindstorms EV3/ev3dev
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
 * NetworkConnectionItem.vala:
 *
 * Provides a view for a network connection (connman service object)
 */

using M2tk;

namespace BrickDisplayManager {
    class NetworkConnectionItem : Object {
        const string checked = "\xa3";
        const string unchecked = "\xa1";

        internal GStrItem _connection_str_item;

        public string name { get; private set; }

        public bool powered {
            get { return _connection_str_item.text == checked; }
            set {
                if (value)
                    _connection_str_item.text = checked;
                else
                    _connection_str_item.text = unchecked;
            }
        }

        public NetworkConnectionItem(string name) {
            this.name = name;
            _connection_str_item = new GStrItem(unchecked, this.name, this);
            _connection_str_item.selected.connect((s, p) => {
                powered = !powered;
            });
        }
    }
}