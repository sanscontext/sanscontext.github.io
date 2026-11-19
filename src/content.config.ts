import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'zod';

const bio = defineCollection({
    loader: glob({ pattern: "bio.md", base: "./src/content" }),
    schema: z.object({
        name: z.string(),
        avatar: z.string(),
        shortBio: z.string().optional(),
        institution: z.string().optional(),
    }),
});

// Unused template collections - commented out for now:
// const publications = defineCollection({ ... });
// const talks = defineCollection({ ... });
// const posts = defineCollection({ ... });
// const teaching = defineCollection({ ... });
// const projects = defineCollection({ ... });
// const cv = defineCollection({ ... });

export const collections = {
    'bio': bio,
    // 'publications': publications,
    // 'talks': talks,
    // 'posts': posts,
    // 'projects': projects,
    // 'cv': cv,
    // 'teaching': teaching,
};
