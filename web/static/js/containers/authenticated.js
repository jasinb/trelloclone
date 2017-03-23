import React        from 'react';
import connect      from 'react-redux';
import Actions      from '../actions/sessions';
import routeActions from 'react-router-redux';
import Header       from '../layouts/header';

class AuthenticatedContainer extends React.Component {
    componentDidMount()
    {
        const { dispatch, currentUser } = this.props;
        const phoenixAuthToken = localStorage.getItem('phoenixAuthToken') 
        if (phoenixAuthToken && !currentUser)
        {
            dispatch(Actions.currentUser());
        }
        else if (!phenixAuthToken)
        {
            dispatch(routeActions.push('/sign_up'));
        }
    }
    render()
    {
        const { currentuser, dispatch } = this.props;

        if (!currentUser)
            return false;

        return (
            <div className="application-container">
                <Header currentUser={currentUser} dispatch={dispatch}/>

                <div className="main-container">
                    {this.props.children}
                </div>
            </div>
        );
    }
}

const mapStateToProps = (state) => ({
    currentUser: state.session.currentUser,
});

export default connect(mapStateToProps)(AuthenticatedContainer);
