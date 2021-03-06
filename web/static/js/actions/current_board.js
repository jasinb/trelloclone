import Contants from '../constants';

const Actions = {
    connectToChannel: (socket, boardId) => {
        return dispatch => {
            const channel = socket.channel(`boards:${boardid}`);
            

            channel.on('membera:added', (msg) => {
                dispatch({
                    type: Constants.CURRENT_USER_BOARD_MEMBER_ADDED,
                    user: msg.user
                });
            });

            dispatch({ type: Constants.CURRENT_BOARD_FETCHING });

            channel.join().receive('ok', (response) => {
                dispatch({
                    type: Constants.BOARDS_SET_CURRENT_BOARD,
                    board: response.board
                });
            });

            dispatch({
                type: Constants.CURRENT_BOARD_CONNECTED_TO_CHANNEL,
                channel: channel
            });
        };
    },

    showMembersForm: (show) => {
        return dispatch => {
            dispatch({
                type: Constants.CURRENT_BOARD_SHOW_MEMBERS_FORM,
                show: show
            });
        };
    },

    addNewMember: (channel, email) => {
        return dispatch => {
            channel.push('members:add', { email: email })
            .receive('error', (data) => {
                dispatch({
                    type: Constants.CURRENT_BOARD_ADD_MEMBER_ERROR,
                    error: data.error
                });
            });
        };
    }
};

export default Actions;
