<template>
  <div
    id="output"
    class="well"
  />
</template>

<script setup name="WordToHTML">
// docx文档预览(只能转换.docx文档，转换过程中复杂样式被忽，居中、首行缩进等)
import mammoth from 'mammoth/mammoth.browser.js'
import { nextTick, onMounted } from 'vue'
const wordURL = '/src/views/WordToHTML/word.docx'// 文件地址
const getWordText = () => {
  const xhr = new XMLHttpRequest()
  xhr.open('get', wordURL, true)
  xhr.responseType = 'arraybuffer'
  xhr.onload = () => {
    console.log(new Uint8Array(xhr.response))
    mammoth.convertToHtml({ arrayBuffer: new Uint8Array(xhr.response) })
      .then(res => {
        displayResult(res)
      })
      .done()
  }
  xhr.send()
}

function displayResult (result) {
  console.log(result)
  nextTick(() => {
    document.getElementById('output').innerHTML = result.value
  })
}
onMounted(() => {
  getWordText()
})
</script>

<style scoped lang="scss">
.well{
  padding: 10px;
  margin: 0;
  p{
    font-size: 16px;
    strong {
      font-weight: bold;
      font-size: 20px;
    }
  }
}
</style>
