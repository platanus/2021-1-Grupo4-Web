/* eslint-env jest */
import { shallowMount } from '@vue/test-utils';
import App from 'app';

describe('App', () => {
  it('displays message on load', () => {
    const wrapper = shallowMount(App);
    expect(wrapper.find('p').text()).toEqual('Hello Vue!');
  });
});
