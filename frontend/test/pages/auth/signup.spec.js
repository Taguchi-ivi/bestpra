import Vuetify from 'vuetify'
import { createLocalVue, shallowMount } from '@vue/test-utils'
import signup from '@/pages/auth/signup.vue'
import UserFormCard from '~/components/Molecules/UserFormCard'
import UserFormName from '~/components/Atom/UserForm/UserFormName'
import UserFormEmail from '~/components/Atom/UserForm/UserFormEmail'
import UserFormPassword from '~/components/Atom/UserForm/UserFormPassword'
import UserFormPasswordAgain from '~/components/Atom/UserForm/UserFormPasswordAgain'


describe('pages/signup.vue', () => {
    const localVue = createLocalVue()
    let vuetify

    beforeEach(() => {
        vuetify = new Vuetify()
    })

    const mountFunction = (options) => {
        return shallowMount(signup, {
            localVue,
            vuetify,
            ...options,
        })
    }

    const componentsViewTest = () => {
        const wrapper = mountFunction()
        expect(wrapper.findComponent(UserFormCard).exists()).toBe(true)
        expect(wrapper.findComponent(UserFormName).exists()).toBe(true)
        expect(wrapper.findComponent(UserFormEmail).exists()).toBe(true)
        expect(wrapper.findComponent(UserFormPassword).exists()).toBe(true)
        expect(wrapper.findComponent(UserFormPasswordAgain).exists()).toBe(true)
    }

    it ('has a signup page', () => {
        const wrapper = mountFunction()
        expect(wrapper.vm).toBeTruthy()
        expect(wrapper.text()).toMatch('登録')
    })

    it ('signup page has components', () => {
        componentsViewTest()
    })
})