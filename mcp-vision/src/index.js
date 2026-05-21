#!/usr/bin/env node
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';
import fs from 'fs/promises';

const server = new Server(
  {
    name: 'mcp-vision-llamacpp',
    version: '1.0.0',
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

const LLAMA_URL = 'http://localhost:8080/v1/chat/completions';
const API_KEY = 'sk-123';

server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [
      {
        name: 'vision_analyze_image',
        description: 'Analyze an image file with Qwen3.6-35B-A3B vision model',
        inputSchema: {
          type: 'object',
          properties: {
            path: {
              type: 'string',
              description: 'Path to the image file'
            },
            prompt: {
              type: 'string',
              description: 'What to analyze',
              default: 'Describe this image in detail. Include colors, shapes, geometry, lighting, and any text or UI elements visible.'
            }
          },
          required: ['path'],
        },
      },
    ],
  };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;
  
  try {
    if (name === 'vision_analyze_image') {
      const { path: imagePath, prompt } = args;
      
      console.error(`[Vision] Analyzing image: ${imagePath}`);
      
      const imageBuffer = await fs.readFile(imagePath);
      const base64Image = imageBuffer.toString('base64');
      console.error(`[Vision] Image size: ${imageBuffer.length} bytes`);
      
      const response = await fetch(LLAMA_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${API_KEY}`
        },
        body: JSON.stringify({
          model: 'Qwen3.6-35B-A3B',
          messages: [
            {
              role: 'user',
              content: [
                { type: 'text', text: prompt },
                {
                  type: 'image_url',
                  image_url: { url: `data:image/png;base64,${base64Image}` }
                }
              ]
            }
          ],
          max_tokens: 2048
        })
      });
      
      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`llama.cpp API error ${response.status}: ${errorText}`);
      }
      
      const data = await response.json();
      const analysis = data.choices[0].message.content;
      
      return {
        content: [
          {
            type: 'text',
            text: `Analysis of ${imagePath}:\n\n${analysis}`
          }
        ]
      };
    }
    
    throw new Error(`Unknown tool: ${name}`);
  } catch (error) {
    console.error(`[Vision] Error: ${error.message}`);
    return {
      content: [
        {
          type: 'text',
          text: `❌ Error: ${error.message}`
        }
      ]
    };
  }
});

const transport = new StdioServerTransport();
server.connect(transport);
console.error('mcp-vision-llamacpp MCP server running');
