
import React, { Component } from 'react'
import { View, StyleSheet, Text, WebView } from 'react-native'
import NavigationBar from 'react-native-navigationbar'

class WebViewPage extends Component {
  constructor (props) {
    super(props)
  }

  render () {
    return (
      <View style={{flex: 1}}>
      <NavigationBar title={this.props.title}
        backHidden={false}
        barTintColor='blue'
        backFunc={() => {
          this.props.navigator.pop()
        }}/>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
      </View>
      )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

// AppRegistry.registerComponent('WebViewPage', () => WebViewPage);
module.exports = WebViewPage
