<template>
    <app-layout>
        <template #header>
            <centered-item :width="centeredItemWidth">
                <h1 class="font-bold text-indigo-600 text-xl">
                    {{ itemHeader }}
                </h1>
            </centered-item>
        </template>

        <centered-item :width="centeredItemWidth">
            <form ref="itemForm" @submit.prevent="submit">
                <item :item="item"
                      :formFields="formFields"
                      :requiredFields="requiredFields"
                      :controllerName="controllerName"
                      @addItem="addItem"
                      @removeItem="removeItem">
                    <div class="mt-4">
                        <e-m-button type="button"
                                    @click.native="visit(listUrl)"
                                    class="hover:text-white hover:bg-indigo-500">
                            {{ __('Cancel') }}
                        </e-m-button>

                        <e-m-button type="button"
                                    @click.native="submit(action, 'apply')"
                                    class="hover:text-white hover:bg-indigo-500">
                            {{ __('Apply') }}
                        </e-m-button>

                        <e-m-button type="button"
                                    @click.native="submit(action, 'save')"
                                    class="hover:text-white hover:bg-indigo-500">
                            {{ __('Save') }}
                        </e-m-button>
                    </div>
                </item>
            </form>
        </centered-item>
    </app-layout>
</template>

<script>
import AppLayout from './AppLayout';
import CenteredItem from './CenteredItem';
import Item from './Item';
import EMButton from './Button';
import qs from 'qs';

export default {
    components: {
        AppLayout,
        CenteredItem,
        Item,
        EMButton,
    },

    props: [
        'item',
        'repeatable',
        'action',
        'formFields',
        'requiredFields',
        'controllerName',
        'controllerNames',
        'listUrl',
    ],

    data() {
        let newItems = {};

        for (const key in this.repeatable) {
            if (this.repeatable.hasOwnProperty(key)) {
                newItems[key] = this.repeatable[key];
            }
        }

        return {
            newItems,
            itemHeader: this.item.default_name || this.__('New ' + this.controllerName),
            centeredItemWidth: {
                md: 'full',
                xl: '10/12',
            },
            errors: {},
        };
    },

    methods: {
        submit(action, type) {
            let
                url = '/' + this.controllerName + '/' + action,
                formData = new FormData(this.$refs.itemForm)
            ;

            if (!this.validateRequiredFields(this.requiredFields, this.$el, this.errors)) {
                return false;
            }

            url += this.item.id ? ('/' + this.item.id) : '';
            formData.append('type', type);
            this.$inertia.post(url, formData);
        },

        visit(url) {
            this.$inertia.visit(url);
        },

        addItem(fieldSetName) {
            this.updateFieldsetList(fieldSetName);
            this.item[fieldSetName].push(this.newItems[fieldSetName]);
        },

        removeItem(fieldSetName, index) {
            this.updateFieldsetList(fieldSetName);
            this.item[fieldSetName].splice(index, 1);
        },

        updateFieldsetList(fieldSetName) {
            const formData = new FormData(this.$refs.itemForm);
            let keyParams = [], k;

            for (const pair of formData.entries()) {
                if (pair[0].startsWith(fieldSetName)) {
                    if (pair[0].indexOf('_date') !== -1) {
                        pair[1] = this.formatDate(pair[1]);
                    }

                    keyParams.push(pair.join('='));
                }
            }

            keyParams = qs.parse(keyParams.join('&'));
            keyParams = keyParams[fieldSetName];

            if (this.item[fieldSetName] !== undefined && keyParams !== undefined) {
                // if (keyParams.length === this.item[fieldSetName].length) {
                this.item[fieldSetName] = keyParams;
                // }
            }
        },
    },
};
</script>
