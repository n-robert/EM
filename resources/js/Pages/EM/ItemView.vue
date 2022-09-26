<template>
    <app-layout>
        <template #header>
            <centered-item :width="centeredItemWidth">
                <h1 class="font-bold text-indigo-600 text-xl">{{ item.default_name }}</h1>
            </centered-item>
        </template>

        <centered-item :width="centeredItemWidth">
            <item :item="item"
                  :formFields="formFields"></item>
        </centered-item>
    </app-layout>
</template>

<script>
import AppLayout from '../../Layouts/AppLayout';
import CenteredItem from './CenteredItem';
import Item from './Item';

export default {
    components: {
        AppLayout,
        CenteredItem,
        Item,
    },

    props: [
        'item',
        'formFields',
    ],

    data() {
        return {
            centeredItemWidth: {
                md: 'full',
                xl: '3/5',
            },
        };
    },
};
</script>
