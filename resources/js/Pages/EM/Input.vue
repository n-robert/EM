<template>
    <div>
        <input v-if="type === 'hidden'" :name="name" :id="id" :value="value" :type="type"/>

        <div v-else>
            <span :class="leftColumn">
                <fmsdocs-label :text="(hasLabel && hasLabel !== 'false') ? (__(labelText) + ': ') : ''"
                               :for="name"
                               :class="[isRequired && (!modelValue || $page.props.errors[name]) ? warningClass : '', labelDefaultClass]"></fmsdocs-label>
            </span>

            <span :class="rightColumn">
                <select v-if="options"
                        :name="name"
                        :value="value"
                        v-model="modelValue"
                        :id="id"
                        :disabled="! $page.props.canEdit"
                        class="form-select"
                        :class="isRequired && (!modelValue || $page.props.errors[name]) ? fieldWarningClass : inputDefaultClass">
                    <option v-for="option in options" :value="option.value">{{__(option.text)}}</option>
                </select>

                <datepicker v-else-if="type === 'date'"
                            :placeholder="__('Select Date')"
                            :name="name"
                            :id="id"
                            v-model="modelValue"
                            :language="ru"
                            :format="$page.props.defaultDateFormat"
                            class="form-input"
                            :class="isRequired && (!modelValue || $page.props.errors[name]) ? fieldWarningClass : inputDefaultClass"></datepicker>

                <textarea v-else-if="type === 'textarea'"
                          :name="name"
                          :id="id"
                          v-model="modelValue"
                          class="form-textarea h-28 resize"
                          :class="isRequired && (!modelValue || $page.props.errors[name]) ? fieldWarningClass : inputDefaultClass"></textarea>

                <fmsdocs-button v-else-if="type === 'button' || type === 'submit'"
                                :type="type"
                                :onclick="[onclick ? onclick : 'this.blur();']"
                                :open="open"
                                :originalText="__(value)"
                                :disabled="! $page.props.canEdit" :customClass="customClass">
                </fmsdocs-button>

                <input v-else-if="type === 'checkbox'"
                       :name="name"
                       :type="type"
                       :value="value"
                       v-model="modelValue"
                       :id="id"
                       :disabled="! $page.props.canEdit"
                       :onclick="onclick"
                       class="form-checkbox"
                       :class="isRequired && (!modelValue || $page.props.errors[name]) ? fieldWarningClass : inputDefaultClass"/>

                <input v-else
                       :name="name"
                       :id="id"
                       :value="value"
                       :type="type"
                       :disabled="! $page.props.canEdit"
                       v-model="modelValue"
                       :onclick="onclick"
                       class="form-input"
                       :class="isRequired && (!modelValue || $page.props.errors[name]) ? fieldWarningClass : inputDefaultClass"/>

                <p v-if="isRequired && (!modelValue || $page.props.errors[name])" :class="[warningClass, pDefaultClass]">
                    {{$page.props.errors[name] ? $page.props.errors[name].join("\r\n") : errorMessage}}
                </p>
            </span>
        </div>
    </div>
</template>

<script>
    import FmsdocsLabel from './Label';
    import FmsdocsButton from './Button';
    import Datepicker from 'vuejs-datepicker';
    import {ru} from 'vuejs-datepicker/dist/locale';

    export default {
        components: {
            FmsdocsLabel,
            FmsdocsButton,
            Datepicker,
        },

        inject: [
            'leftColumn',
            'rightColumn',
            'warningClass',
            'labelDefaultClass',
            'inputDefaultClass',
            'fieldWarningClass',
            'pDefaultClass',
        ],

        props: {
            name: {
                defautl: null,
            },
            type: {
                default: 'text',
            },
            value: {
                defautl: null,
            },
            options: {
                default: null,
            },
            checked: {
                default: false,
            },
            id: {
                defautl: null,
            },
            onclick: {
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
        },

        data()
        {
            const
                labelText = this.label || this.name || '',
                errorMessage = this.__('Field ":fieldName" is required.', {fieldName: this.__(this.name)});


            return {
                ru: ru,
                modelValue:
                    this.type === 'date' ? (this.value ?? new Date()) :
                        this.type === 'checkbox' ? this.checked :
                            this.value || null,
                labelText: labelText.toString().replace(/[^\w\s]/gi, ''),
                errorMessage: errorMessage,
            };
        },

//        watch: {
//            error: {
//                immediate: true,
//                handler: (newVal, oldVal) => {
//                    console.log('new: %s, old: %s', newVal, oldVal);
//                },
//            },
//        },
    };
</script>