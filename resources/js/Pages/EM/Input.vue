<template>
    <div v-show="show" :id="parenId">
        <input v-if="type === 'hidden'" :name="name" :id="id" :value="value" :type="type"/>

        <div v-else>
            <span :class="leftColumn">
                <em-label
                    :text="(hasLabel && hasLabel !== 'false' && labelText) ? (__(labelText).toPhrase(true)) : ''"
                    :for="name"
                    :class="[isRequired && (!modelValue || page.props.errors[name]) ? warningClass : '', labelDefaultClass]"></em-label>
            </span>

            <span :class="rightColumn">
                <select v-if="options"
                        :multiple="multiple"
                        :name="name"
                        v-model="modelValue"
                        :id="id"
                        :onchange="onchange"
                        :disabled="disabled || ! page.props.canEdit"
                        :class="isRequired && (!modelValue || page.props.errors[name]) ? fieldWarningClass : inputDefaultClass">
                    <option v-for="option in options" v-if="option !== null" :value="option.value">{{
                            __(option.text)
                        }}</option>
                </select>

                <datepicker v-else-if="type === 'date'"
                            :placeholder="__('Select Date')"
                            :name="name"
                            :id="id"
                            v-model="modelValue"
                            :language="ru"
                            :format="page.props.defaultDateFormat"
                            :clear-button="clearButton"
                            :highlighted="highlighted"
                            :input-class=
                                "isRequired && (!modelValue || page.props.errors[name]) ?
                                fieldWarningClass : inputDefaultClass"></datepicker>

                <textarea v-else-if="type === 'textarea'"
                          :name="name"
                          :id="id"
                          v-model="modelValue"
                          :class="[
                              isRequired && (!modelValue || page.props.errors[name]) ? fieldWarningClass : inputDefaultClass,
                              textareaDefaultClass]"></textarea>

                <em-button v-else-if="type === 'button' || type === 'submit'"
                            :type="type"
                            :onclick="onclick"
                            :open="open"
                            :originalText="__(value)"
                            :disabled="disabled || ! page.props.canEdit"
                            :customClass="customClass">
                </em-button>

                <input v-else-if="type === 'checkbox'"
                       :name="name"
                       :type="type"
                       v-model="modelValue"
                       :id="id"
                       :disabled="disabled || ! page.props.canEdit"
                       :onclick="onclick"
                       :class=
                           "isRequired && (!modelValue || page.props.errors[name]) ?
                           fieldWarningClass : inputDefaultClass"/>

                <input v-else
                       :name="name"
                       :id="id"
                       :type="type"
                       :disabled="disabled || ! page.props.canEdit"
                       v-model="modelValue"
                       :onclick="onclick"
                       :class=
                           "isRequired && (!modelValue || page.props.errors[name]) ?
                           fieldWarningClass : inputDefaultClass"/>

                <p v-if="isRequired && (!modelValue || page.props.errors[name])"
                   :class="[warningClass, pDefaultClass]">
                    {{ page.props.errors[name] ? page.props.errors[name] : errorMessage }}
                </p>
            </span>
        </div>
    </div>
</template>

<script>
import EmLabel from './Label';
import EmButton from './Button';
import Datepicker from 'vuejs-datepicker';
import {ru} from 'vuejs-datepicker/dist/locale';

export default {
    components: {
        EmLabel,
        EmButton,
        Datepicker,
    },

    inject: [
        'leftColumn',
        'rightColumn',
        'warningClass',
        'labelDefaultClass',
        'inputDefaultClass',
        'textareaDefaultClass',
        'fieldWarningClass',
        'pDefaultClass',
    ],

    props: {
        name: {
            default: null,
        },
        type: {
            default: 'text',
        },
        disabled: {
            default: false,
        },
        multiple: {
            default: false,
        },
        value: {
            default: null,
        },
        options: {
            default: null,
        },
        checked: {
            default: false,
        },
        id: {
            default: null,
        },
        onclick: {
            default: null,
        },
        onchange: {
            default: null,
        },
        open: {
            default: false,
        },
        label: {
            default: null,
        },
        hasLabel: {
            default: true,
        },
        isRequired: {
            default: false,
        },
        customClass: {
            default: null,
        },
        parenId: {
            default: null,
        },
        show: {
            default: true,
        },
    },

    data() {
        const labelText = this.label || this.name || '';

        return {
            page: this.$page,
            ru: ru,
            modelValue:
                this.type === 'checkbox' ? this.checked : this.value || null,
            labelText: labelText.toString().replace(/[^\w\s]/gi, ''),
            clearButton: true,
            errorMessage: this.__(
                'Field ":fieldName" is required.',
                {fieldName: this.__(this.name)}
            ),
            highlighted: {
                from: new Date().setDate(new Date().getDate() - 1),
                to: new Date(),
            },
        };
    },

    // watch: {
    //     error: {
    //         immediate: true,
    //         handler: (newVal, oldVal) => {
    //             console.log('new: %s, old: %s', newVal, oldVal);
    //         },
    //     },
    // },
};
</script>
