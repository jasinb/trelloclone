import Constants from '../constants';
import { Socket } from '../phoenix';

export function setCurrentUser(dispatch, user)
{
    dispatch({
        type: Constants.CURRENT_USER,
        currentUser: user
    });

    const socket = new Socket('/socket', {
        params: { token: localStorage.getItem('phoenixAuthToken') }
    });

    socket.connect();

    const channel = socket.channel(`users:${user.id}`);
    channel.join().receive('ok', () => {
        dispatch({
            type: Constants.SOCKET_CONNECTED,
            socket: socket,
            channel: channel
        });
    });
};


