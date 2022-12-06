import { shallowMount } from '@vue/test-utils'
import Index from '../pages/index.vue'

// const windowOpen = jest.fn();
// windowOpen.mockReturnValue({ opener: null });

// global.open = windowOpen;

const wrapper = shallowMount(Index)
describe('pages/index.vue', () => {
    test('Display test', () => {
        expect(wrapper.text()).toMatch('testtest');
    })
})