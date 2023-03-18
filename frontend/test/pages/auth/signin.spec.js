import Vuetify from 'vuetify'
import { createLocalVue, shallowMount } from '@vue/test-utils'
import signin from '@/pages/auth/signin.vue'
import UserFormCard from '~/components/Molecules/UserFormCard'
import UserFormEmail from '~/components/Atom/UserForm/UserFormEmail'
import UserFormPassword from '~/components/Atom/UserForm/UserFormPassword'


describe('pages/signin.vue', () => {
    const localVue = createLocalVue()
    let vuetify

    beforeEach(() => {
        vuetify = new Vuetify()
    })

    const mountFunction = (options) => {
        return shallowMount(signin, {
            localVue,
            vuetify,
            ...options,
        })
    }

    const componentsViewTest = () => {
        const wrapper = mountFunction()
        expect(wrapper.findComponent(UserFormCard).exists()).toBe(true)
        expect(wrapper.findComponent(UserFormEmail).exists()).toBe(true)
        expect(wrapper.findComponent(UserFormPassword).exists()).toBe(true)
    }

    it ('has a signin page', () => {
        const wrapper = mountFunction()
        expect(wrapper.vm).toBeTruthy()
        expect(wrapper.text()).toMatch('ログインする')
    })

    it ('signin page has components', () => {
        componentsViewTest()
    })


})