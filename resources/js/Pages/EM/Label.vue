<template>
    <label :for="this.for" :class="$page.props.errors[this.for] ? warningClass : labelDefaultClass">
        {{text}}
        <slot></slot>
    </label>
</template>

<script>
    export default {
        inject: [
            'warningClass',
            'labelDefaultClass',
        ],

        props: {
            for: {
                default: null,
            },
            text: {
                defautl: null,
            },
        },
    };
</script>