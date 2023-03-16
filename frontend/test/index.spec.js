// TODO 不要になるので最後に消す
// portfolio/bestpra/frontend/test/index.spec.js

import { mount } from '@vue/test-utils'
import Index from '@/pages/index.vue'

describe('pages/index.vue', () => {
    test('has a default value', () => {
        const wrapper = mount(Index)
        // expect(wrapper.text()).toBe('Test vue!!')
        expect(wrapper.text()).toMatch('Test vue!!')
    })
})
